public class CaseCallout 
{
    @future(callout=true)
    public static void sendCases(String casesJson) 
    {
        List<Object> serializedCases = (List<Object>) JSON.deserializeUntyped(casesJson);

        for (Object obj : serializedCases) 
        {
            ///deserialize
            Case c = (Case) JSON.deserialize(JSON.serialize(obj), Case.class);

            HttpRequest req = new HttpRequest();
            req.setEndpoint('http://salesforce-cases-integration-flow.de-c1.cloudhub.io/case');
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            ///req.setHeader('client-id', 'client123');
            ///req.setHeader('client-secret', 'clientsecret123');

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
