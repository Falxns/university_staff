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
  public void Deletingfileinrepository() {
    driver.Navigate().GoToUrl("https://github.com/");
    driver.Manage().Window.Size = new System.Drawing.Size(945, 1060);
    driver.FindElement(By.CssSelector(".Header-link:nth-child(1) > .avatar")).Click();
    driver.FindElement(By.LinkText("Your repositories")).Click();
    driver.FindElement(By.LinkText("Test1")).Click();
    driver.FindElement(By.LinkText("Test")).Click();
    driver.FindElement(By.CssSelector(".octicon-trashcan")).Click();
    driver.FindElement(By.Id("submit-file")).Click();
  }
}
