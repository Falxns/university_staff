using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Firefox;
using OpenQA.Selenium.Remote;
using OpenQA.Selenium.Support.UI;
using OpenQA.Selenium.Interactions;
using Xunit;
public class SuiteTests : IDisposable {
  public IWebDriver driver {get; private set;}
  public IDictionary<String, Object> vars {get; private set;}
  public IJavaScriptExecutor js {get; private set;}
  public SuiteTests()
  {
    driver = new ChromeDriver();
    js = (IJavaScriptExecutor)driver;
    vars = new Dictionary<String, Object>();
  }
  public void Dispose()
  {
    driver.Quit();
  }
  [Fact]
  public void Addingfiletorepository() {
    driver.Navigate().GoToUrl("https://github.com/");
    driver.Manage().Window.Size = new System.Drawing.Size(945, 1060);
    driver.FindElement(By.CssSelector(".js-feature-preview-indicator-container > .Header-link")).Click();
    driver.FindElement(By.LinkText("Your repositories")).Click();
    driver.FindElement(By.LinkText("Test1")).Click();
    driver.FindElement(By.CssSelector(".btn > .d-none")).Click();
    driver.FindElement(By.CssSelector("form > .dropdown-item")).Click();
    driver.FindElement(By.Name("filename")).Click();
    driver.FindElement(By.Name("filename")).SendKeys("Test");
    driver.FindElement(By.CssSelector(".CodeMirror-line")).Click();
    driver.FindElement(By.CssSelector(".CodeMirror-line")).SendKeys("T");
    driver.FindElement(By.CssSelector(".CodeMirror-line")).SendKeys("Te");
    driver.FindElement(By.CssSelector(".CodeMirror-line")).SendKeys("Tes");
    driver.FindElement(By.CssSelector(".CodeMirror-line")).SendKeys("Test");
    {
      var element = driver.FindElement(By.CssSelector(".CodeMirror-code"));
      js.ExecuteScript("if(arguments[0].contentEditable === 'true') {arguments[0].innerText = '<div style=\"position: relative;\"><div class=\"CodeMirror-gutter-wrapper\" contenteditable=\"false\" style=\"left: -53px;\"><div class=\"CodeMirror-linenumber CodeMirror-gutter-elt\" style=\"left: 0px; width: 21px;\">1</div></div><pre class=\" CodeMirror-line \" role=\"presentation\"><span role=\"presentation\" style=\"padding-right: 0.1px;\">Test</span></pre></div>'}", element);
    }
    driver.FindElement(By.Id("submit-file")).Click();
  }
}
