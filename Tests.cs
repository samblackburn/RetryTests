namespace RetryTests;

public class Tests
{
    [Test]
    public void PassingTest()
    {
        Assert.Pass();
    }

    [Test]
    public void FailingTest()
    {
        Assert.Fail();
    }
}
