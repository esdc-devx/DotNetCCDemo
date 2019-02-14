using Microsoft.VisualStudio.TestTools.UnitTesting;
using examplecode;

namespace webpoctest
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestAdd()
        {

            var foo = new Foo();
            Assert.AreEqual(2,foo.add(1,1));
        }
    }
}
