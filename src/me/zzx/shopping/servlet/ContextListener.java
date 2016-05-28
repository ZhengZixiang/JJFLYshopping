package me.zzx.shopping.servlet;

import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.mysql.jdbc.log.StandardLogger;;

/**
 * Application Lifecycle Listener implementation class ContextListener
 *
 */
@WebListener
public class ContextListener implements ServletContextListener {
	StandardLogger log = new StandardLogger("log");
    /**
     * Default constructor. 
     */
    public ContextListener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent sce)  { 
        // ... First close any background tasks which may be using the DB ...
        // ... Then close any DB connection pools ...

        // Now deregister JDBC drivers in this context's ClassLoader:
        // Get the webapp's ClassLoader
        ClassLoader cl = Thread.currentThread().getContextClassLoader();
        // Loop through all drivers
        Enumeration<Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            if (driver.getClass().getClassLoader() == cl) {
                // This driver was registered by the webapp's ClassLoader, so deregister it:
                try {
                    log.logInfo("Deregistering JDBC driver: " + driver);
                    DriverManager.deregisterDriver(driver);
                } catch (SQLException ex) {
                    log.logError("Error deregistering JDBC driver: " + driver + "with exception: " + ex);
                }
            } else {
                // driver was not registered by the webapp's ClassLoader and may be in use elsewhere
                log.logTrace("Not deregistering JDBC driver {} as it does not belong to this webapp's ClassLoader: " + driver);
            }
        }
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent sce)  { 
         // TODO Auto-generated method stub
    }
	
}
