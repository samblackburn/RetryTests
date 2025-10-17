namespace RetryTests;

public class Tests
{
    [Test]
    public void FlakyTest([Values(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)] int tens,
                          [Values(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)] int units,
                          [Values("`!$%^&*()_+-=")] string foo)
    {
        if (new Random().Next(0, 50) > 0)
        {
            Assert.Pass("Test passed");
        }
        else
        {
            Assert.Fail("Test failed");
        }
    }
}
