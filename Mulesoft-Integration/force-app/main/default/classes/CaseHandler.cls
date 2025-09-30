public with sharing class CaseHandler
{
    public void afterInsert(List<Case> newCases)
    {
        for (Case c : newCases) 
        {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('localhost:8081/case');
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('client-id', 'YOUR_CLIENT_ID_HERE');
            req.setHeader('client-secret', 'YOUR_CLIENT_SECRET_HERE');

            String ownerName = [SELECT Name FROM User WHERE Id =: c.OwnerId].Name;

            String body = '{"recordId": "' + c.Id + '", "subject": "' + c.Subject + '", "priority": "' + c.Priority + '", "status": "' + c.Status + '", "origin": "' + c.Origin +'", "ownerId": "' + c.OwnerId +'", "owner": "' + ownerName + '"}';
            System.debug('Request Body: ' + body);

            Http http = new Http();
            req.setBody(body);

            HttpResponse res = http.send(req);
            System.debug('Response: ' + res.getBody());
        }
    }
}