/**
 * @author Gavin Palmer
 * @date 2019-02-02
 *
 **/
@SuppressWarnings('PMD.UnusedLocalVariable')
@IsTest(isParallel=true)
private class ApexProfilerTest {
    @IsTest
    private static void refreshProfilingTest() {
        Test.startTest();
        ApexProfiler profiler = new ApexProfiler();
        System.assertEquals(
            profiler.profilingInfos.get('Queries').recorded,
            0,
            'The profiling for queries should be 0 before any queries are performed'
        );
        List<Account> testQuery = [SELECT Id FROM Account LIMIT 1];
        profiler.refreshProfiling();
        System.assertEquals(
            profiler.profilingInfos.get('Queries').recorded,
            1,
            'The profiling for queries should be 1 after a query is performed'
        );
        Test.stopTest();
    }

    @IsTest
    private static void isBreachingWarningTestNoBreach() {
        Test.startTest();
        ApexProfiler profiler = new ApexProfiler();
        // Set to not include org limits for this test as this is
        System.assert(
            !profiler.isBreachingWarning(),
            'The warning should not be breached before any apex code is executed. Report:\n' +
            profiler.getProfilingReport()
        );
        Test.stopTest();
    }

    @IsTest
    @SuppressWarnings('PMD.OperationWithLimitsInLoop')
    private static void isBreachingWarningTestBreach() {
        Test.startTest();
        ApexProfiler apexProfiler = new ApexProfiler();
        Integer queriesToRun =
            Integer.valueOf(
                Math.ceil(
                    apexProfiler.profilingInfos.get('Queries').limitTotal *
                    Profiler.DEFAULT_WARNING_PERCENTAGE
                )
            ) + 1;
        for (Integer i = 0; i < queriesToRun; i++) {
            List<Account> testQuery = [SELECT Id FROM Account LIMIT 1];
        }
        apexProfiler.refreshProfiling();
        System.assert(
            apexProfiler.isBreachingWarning(),
            'The warning should be flagged when the queries have run'
        );
        Test.stopTest();
    }

    @IsTest
    private static void getProfilingReportTest() {
        ApexProfiler profiler = new ApexProfiler();
        System.assert(
            String.isNotBlank(profiler.getProfilingReport()),
            'The profiling report should not be empty'
        );
    }
}
