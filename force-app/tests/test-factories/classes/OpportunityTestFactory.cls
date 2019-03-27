/**
* @author Gavin Palmer (gavin.palmer@cloudshiftgroup.com)
* @version 1.0
*
* 2019-03-06 : Gavin Palmer - Original
**/
@IsTest
public without sharing class OpportunityTestFactory extends AbstractSObjectTestFactory {

    public static final String DEFAULT_STAGE = 'New';

    public Id accountId;
    public String name = 'Test Opp';
    public Date closeDate = Date.today();
    public String stage = DEFAULT_STAGE;
    public Id ownerId = UserInfo.getUserId();
    public String salesTargetRefrence;

    public override SObject getSObject() {
        return new Opportunity(
            AccountId = accountId,
            Name = name,
            CloseDate = closeDate,
            StageName = stage,
            OwnerId = ownerId
        );
    }

    public override void initialiseDependancies() {
        dependancies.add(
            new FactoryDependancy(
                new AccountTestFactory(),
                'AccountId'
            )
        );
    }
}