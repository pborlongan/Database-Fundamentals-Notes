# BOOK TITLE VIEW

## 0NF: List all attributes and make them atomic

After performing Zero Normal Form, a new entity was generated: **_Sale_**

**Sale:** ( <b class="pk">SaleNumber</b>, Date, CustomerFirstName, CustomerLastName, Address, Province, City, PostalCode, CustomerNumber, EmployeeFirstName, EmployeeLastName, EmployeeNumber, <b class="gr">{</b> ISBN, BookTitle, Price, Quantity, Amount <b class="gr">}</b>, Subtotal, GST, Total )


## 1NF: Repeating Groups

After performing First Normal Form, a new entity was generated: **_SaleDetail_**

**SaleDetail:** ( <b class="pk"><u class="fk">SaleNumber</u>, ISBN</b>, BookTitle, Price, Quantity, Amount )

## 2NF: Partial Dependencies

After performing Third Normal Form, a new entity was generated: **_Book_**

**Book:** ( <b class="pk">ISBN</b>, BookTitle, Price )

## 3NF: Transitive Dependencies

After performing Third Normal Form, two new entities were generated: **_Customer_** & **_Employee_**

**Customer:** ( <b class="pk">CustomerNumber</b>, CustomerFirstName, CustomerLastName, Address, Province, City, PostalCode )

**Category:** ( <b class="pk">CategoryCode</b>, EmployeeFirstName, EmployeeLastName )


# Entities After 3NF:

**Sale:** ( <b class="pk">SaleNumber</b>, <u class="fk">CustomerNumber</u>, <u class="fk">EmployeeNumber</u>, Date, Subtotal, GST, Total)

**SaleDetail:** ( <b class="pk"><u class="fk">SaleNumber</u>, <u class="fk">ISBN</u></b>, BookTitle, Price, Quantity, Amount )

**Book:** ( <b class="pk">ISBN</b>, BookTitle, Price )

**Customer:** ( <b class="pk">CustomerNumber</b>, CustomerFirstName, CustomerLastName, Address, Province, City, PostalCode )

**Category:** ( <b class="pk">CategoryCode</b>, EmployeeFirstName, EmployeeLastName )







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