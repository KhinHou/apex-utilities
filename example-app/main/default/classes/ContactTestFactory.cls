/**
* @author Gavin Palmer
*
* @date 2018-10-23
**/
@IsTest
public without sharing class ContactTestFactory extends AbstractSObjectTestFactory {

    public String lastName = 'TestUser';
    public Id accountId;

    public ContactTestFactory() {
        addDependancy('AccountId', new AccountTestFactory());
    }

    public override SObject getSObject() {
        return new Contact(
            AccountId = accountId,
            LastName = lastName
        );
    }
}
