public class ExternalSharingHelper { 
    
    @future 
    public static void linkContact(Map<Id,Id> contactIdMap) { 
  
        Set<Id> partnerContactIdSet = new Set<Id>(); 
        for (Id partnerContactId : contactIdMap.values()) { 
            partnerContactIdSet.add(partnerContactId); 
        } 
        
        Map<Id,Id> contactMap = new Map<Id,Id>(); 
        
        for (PartnerNetworkRecordConnection contactConnection : 
            [SELECT Id, Status, ConnectionId, PartnerRecordId, LocalRecordId 
             FROM PartnerNetworkRecordConnection 
             WHERE PartnerRecordId in :partnerContactIdSet]) { 
                
            if ( contactConnection.Status == 'Sent' || contactConnection.Status == 'Received') {                                                                
                contactMap.put(contactConnection.PartnerRecordId, contactConnection.LocalRecordId); 
            } 
        } 
  
        List<Contact> localContactList = new List<Contact>(); 
        
        for (Id contactId : contactIdMap.keySet()) { 
            Contact contactForUpdate = new Contact(id=contactId); 
            contactForUpdate.ReportsToId  =  contactMap.get(contactIdMap.get(contactId)); 
            
            localContactList.add(contactForUpdate);                                                          
        }                                                            
        
        database.update(localContactList); 
      }
     }