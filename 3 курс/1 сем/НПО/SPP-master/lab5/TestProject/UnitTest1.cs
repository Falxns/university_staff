using System.Collections.Generic;
using Dependency_Injection_Library;
using Moq;
using NUnit.Framework;

namespace TestProject
{
    public interface IService {}

    public class ServiceImpl1 : IService {}

    class ServiceImpl2 : IService {}
    
    abstract class AbstractService : IService {}
    
    class Service2 : AbstractService {}
    
    class ServiceImpl : IService
    {
        public ServiceImpl(IRepository repository) {}
    }

    interface IRepository{}
    
    class RepositoryImpl : IRepository
    {
        public RepositoryImpl(){}
    }
    
    interface IService<TRepository> where TRepository : IRepository {}

    class ServiceImpl<TRepository> : IService<TRepository> 
        where TRepository : IRepository
    {
        public TRepository Repository;
        public ServiceImpl(TRepository repository)
        {
            Repository = repository;
        }
    }

    class MySqlRepository : IRepository {}
    
    public class Tests
    {
        [Test]
        public void CountMock()
        {
            Mock<IService> mock = new Mock<IService>();
            Mock<ServiceImpl1> mock1 = new Mock<ServiceImpl1>();
            var dependencies = new DependenciesConfig();
            dependencies.Register(mock.Object.GetType(), mock1.Object.GetType());
            dependencies.Register(mock1.Object.GetType(), mock1.Object.GetType());
            Assert.AreEqual(2, dependencies.Count());
        }
        
        [Test]
        public void Count()
        {
            var dependencies = new DependenciesConfig();
            dependencies.Register<IService, ServiceImpl1>();
            dependencies.Register<AbstractService, Service2>();
            dependencies.Register<ServiceImpl1, ServiceImpl1>();
            Assert.AreEqual(3, dependencies.Count());
        }
        
        [Test]
        public void ResolveBasic()
        {
            var dependencies = new DependenciesConfig();
            dependencies.Register<IService, ServiceImpl1>();
            dependencies.Register<AbstractService, Service2>();
            
            var provider = new DependencyProvider(dependencies);
            var service1 = provider.Resolve<IService>();

            Assert.AreEqual( typeof(ServiceImpl1), service1.GetType());
        }
        
        [Test]
        public void ResolveRecursive()
        {
            var dependencies = new DependenciesConfig();
            dependencies.Register<IService, ServiceImpl>();
            dependencies.Register<IRepository, RepositoryImpl>();
            
            var provider = new DependencyProvider(dependencies);
            var service = provider.Resolve<IService>();

            Assert.AreEqual( typeof(ServiceImpl), service.GetType());
        }
        
        
        [Test]
        public void ResolveSingleton()
        {
            var dependencies = new DependenciesConfig();
            dependencies.Register<IService, ServiceImpl1>(isSingleton: true);
            
            var provider = new DependencyProvider(dependencies);
            var service1 = provider.Resolve<IService>();
            var service2 = provider.Resolve<IService>();

            Assert.AreSame( service1, service2);
        }
        
        [Test]
        public void ResolveEnumerable()
        {
            var dependencies = new DependenciesConfig();
            dependencies.Register<IService, ServiceImpl1>();
            dependencies.Register<IService, ServiceImpl2>();
            
            var provider = new DependencyProvider(dependencies);
            var services = provider.Resolve<IEnumerable<IService>>();
        
            Assert.AreEqual(2, (services as List<object>)?.Count);    
        }
        
        [Test]
        public void ResolveGenericDependency()
        {
            var dependencies = new DependenciesConfig();
            dependencies.Register<IRepository, MySqlRepository>();
            dependencies.Register<IService<IRepository>, ServiceImpl<IRepository>>();
            
            var provider = new DependencyProvider(dependencies);
            var service = provider.Resolve<IService<IRepository>>();
        
            Assert.NotNull((service as ServiceImpl<IRepository>)?.Repository);    
        }
        
        [Test]
        public void ResolveOpenGenericsDependency()
        {
            var dependencies = new DependenciesConfig();
            dependencies.Register<IRepository, MySqlRepository>();
            dependencies.Register(typeof(IService<>), typeof(ServiceImpl<>));
            
            var provider = new DependencyProvider(dependencies);
            var service = provider.Resolve<IService<IRepository>>();
        
            Assert.NotNull((service as ServiceImpl<IRepository>)?.Repository);    
        }
    }
}