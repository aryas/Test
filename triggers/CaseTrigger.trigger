trigger CaseTrigger on Case (after insert, after update) { 
  
    // define connection id for Force Corp Org. 
    Id networkId = ConnectionHelper.getConnectionId('Shazlik'); 
    // build the ACME local contact id to Force Corp contact map 
    Map<Id,Id> caseIdMap = new Map<Id,Id>(); 
     
    for (Case newCase : Trigger.new) { 
   
                    system.debug('new value '+newCase.RemoteContactID__c);
        if (newCase.RemoteContactID__c != null && newCase.RemoteContactID__c != '' && newCase.lastModifiedById == ConnectionHelper.getConnectionOwnerId('Shazlik')) { 
           
            
               caseIdMap.put(newCase.id, newCase.RemoteContactID__c); 
            } 
        } 
    
   system.debug('the caseidmap has a value of'+caseIdMAP.keyset()+caseIdMap.size());
   system.debug('connection id user has value of'+ConnectionHelper.getConnectionOwnerId('Shazlik'));
    // call future method to link local Contact corresponding to Force Corp's reports to contact. 
  /* if (contactIdMap.size() > 0) { 
        ExternalSharingHelper.linkContact(contactIdMap); 
    } */
}