// Executes actual session_recovery.js with a minimal DOM boundary and independent token oracle.
import {readFileSync,writeFileSync} from 'node:fs';
import vm from 'node:vm';
import assert from 'node:assert/strict';
const source=readFileSync(process.argv[2],'utf8');
const owner='synthetic-owner',tenant='synthetic-tenant',fresh='new-valid-csrf';
const callbacks={};let submitted=null;let fetches=0;
class Form {
  method='post';action='http://testserver/oauth/authorize';
  token={value:'synthetic-invalid-csrf'};
  querySelectorAll(){return [this.token];}
  requestSubmit(){submitted=this.token.value;}
}
const form=new Form();
const context={document:{body:{dataset:{sessionOwner:owner,sessionTenant:tenant}},addEventListener:(name,callback)=>callbacks[name]=callback},
               HTMLFormElement:Form,URL,location:{origin:'http://testserver'},
               fetch:async url=>{assert.equal(url,'/auth/session');fetches++;return {ok:true,json:async()=>({active:true,owner_id:owner,tenant_id:tenant,csrf:fresh})};}};
vm.runInNewContext(source,context);
await callbacks.submit({target:form,preventDefault(){},stopImmediatePropagation(){},submitter:null});
assert.equal(fetches,1);assert.equal(submitted,fresh);assert.notEqual(submitted,'synthetic-invalid-csrf');
const result={actual_script:'session_recovery.js',route:'/oauth/authorize',initial_dom_token:'invalid synthetic marker',
              session_preflight_calls:fetches,submitted_matches_refreshed_valid_token:submitted===fresh,
              invalid_dom_token_replaced:true,scope:'Source JS execution with minimal DOM/fetch boundary, no browser/provider proof'};
writeFileSync(process.argv[3],JSON.stringify(result,null,2)+'\n');console.log(JSON.stringify(result));
