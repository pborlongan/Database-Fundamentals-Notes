# EMPLOYEE VIEW


## 0NF: List all attributes and make them atomic

After performing Zero Normal Form, a new entity was generated: **_Employee_**

**Employee**: ( <b class="pk">EmployeeNumber</b>, SIN, FirstName, LastName, Address, City, PostalCode, HomePhone, WorkPhone, Email, EmployeeGroupCode, EmployeeGroupName, Wage )

## 1NF: Repeating Groups

After performing First Normal Form, no new entity was generated.

## 2NF: Partial Dependencies

After performing Third Normal Form, a new entity was generated: **_EmployeeGroup_**

**EmployeeGroup**: ( <b class="pk"><u class="fk">EmployeeNumber</u>, EmployeeGroupCode</b>, EmployeeGroupName, Wage )

## 3NF: Transitive Dependencies

After performing Third Normal Form, no new entity was generated.

## Entities After 3NF:

**Employee**: ( <b class="pk">EmployeeNumber</b>, SIN, FirstName, LastName, Address, City, PostalCode, HomePhone, WorkPhone, Email )

**EmployeeGroup**: ( <b class="pk"><u class="fk">EmployeeNumber</u>, EmployeeGroupCode</b>, EmployeeGroupName, Wage )

## ERD
The following ERD represents the tables/entities from the **Employee View**

![](Employee-View-ERD.png)



-------------
<style type="text/css"> 

.pk {
    font-weight: bold; 
    display: inline-block; 
    border: solid thin blue; 
    padding: 0 1px; 
}

.tk { 
    color: orange; 
    font-weight: bold;
}

.fk { 
    color: green; 
    font-style: italic; 
    text-decoration: wavy underline green;
} 

.gr { 
    color: darkorange; 
    font-size: 1.2em; 
    font-weight: bold; 
} 
    
</style>