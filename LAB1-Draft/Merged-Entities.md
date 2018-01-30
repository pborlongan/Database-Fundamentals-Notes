# Merged Entities

To avoid duplicated entities, we merged entities with the same name and same primary/foreign keys.

Here are the following merged entities:

- **Employee** from Employee View and **Employee** from Sale View
    - after merging the two tables, a single **Employee** entity was generated:

        **Employee:** ( <b class="pk">EmployeeNumber</b>, SIN, FirstName, LastName, Address, City, PostalCode, HomePhone, WorkPhone, Email )

- **Book** from Book Title View and **Book** from Sale View
    - after merging the two tables, a single **Book** entity was generated:

        **Book:** ( <b class="pk">ISBN</b>, <u class="fk">PublisherCode</u>, <u class="fk">CategoryCode</u>, BookTitle, SuggestedRetailPrice, NumberInStock)

        

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