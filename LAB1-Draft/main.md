# Books Galore

## EMPLOYEE VIEW

The Employee View and its resulting tables are based on the following form:

![](Employee-View-Image.png)


### 0NF: List all attributes and make them atomic

After performing Zero Normal Form, a new entity was generated: **_Employee_**

**Employee**: ( <b class="pk">EmployeeNumber</b>, SIN, FirstName, LastName, Address, City, PostalCode, HomePhone, WorkPhone, Email, EmployeeGroupCode, EmployeeGroupName, Wage )

### 1NF: Repeating Groups

After performing First Normal Form, no new entity was generated.

### 2NF: Partial Dependencies

After performing Second Normal Form, no new entity was generated.

### 3NF: Transitive Dependencies

After performing Third Normal Form, a new entity was generated: **_EmployeeGroup_**

**EmployeeGroup**: ( <b class="pk">EmployeeGroupCode</b>, EmployeeGroupName, Wage )

### Entities After 3NF:

Here are the tables/entities after normalizing the Employee View:

**Employee**: ( <b class="pk">EmployeeNumber</b>, SIN, FirstName, LastName, <u class="fk">EmployeeGroupCode</u>, Address, City, PostalCode, HomePhone, WorkPhone, Email )

**EmployeeGroup**: ( <b class="pk">EmployeeGroupCode</b>, EmployeeGroupName, Wage )

### ERD
The following ERD represents the tables/entities from the **Employee View**

![](Employee-View-ERD.png)

--------------

## BOOK TITLE VIEW


### 0NF: List all attributes and make them atomic

After performing Zero Normal Form, a new entity was generated: **_Book_**

**Book**: ( <b class="pk">ISBN</b>, Title, SuggestedSellingPrice, NumberInStock, PublisherCode, Publisher Name, <b class="gr">{</b> AuthorCode, AuthorFirstName, AuthorLastName <b class="gr">}</b>, CategoryCode, CategoryDescription )

### 1NF: Repeating Groups

After performing First Normal Form, a new entity was generated: **_Author_**

**Author**: ( <b class="pk"><u class="fk">ISBN</u>, AuthorCode</b>, AuthorFirstName, AuthorLastName )

### 2NF: Partial Dependencies

After performing Second Normal Form, no new entity was generated.

### 3NF: Transitive Dependencies

After performing Third Normal Form, two new entities were generated: **_Publisher_** & **_Category_**

**Publisher**: ( <b class="pk">PublisherCode</b>, PublisherName )

**Category**: ( <b class="pk">CategoryCode</b>, CategoryDescription )


### Entities After 3NF:

Here are the tables/entities after normalizing the Book Title View:

**Book**: ( <b class="pk">ISBN</b>, <u class="fk">PublisherCode</u>, <u class="fk">CategoryCode</u>, Title, SuggestedSellingPrice, NumberInStock )

**Author**: ( <b class="pk"><u class="fk">ISBN</u>, AuthorCode</b>, FirstName, LastName )

**Publisher**: ( <b class="pk">PublisherCode</b>, PublisherName )

**Category**: ( <b class="pk">CategoryCode</b>, CategoryDescription )


### ERD
The following ERD represents the tables/entities from the **Book Title View**

![](Book-Title-View-ERD.png)



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
