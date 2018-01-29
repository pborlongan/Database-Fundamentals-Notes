# BOOK TITLE VIEW


## 0NF: List all attributes and make them atomic

After performing Zero Normal Form, a new entity was generated: **_Book_**

**Book**: ( <b class="pk">ISBN</b>, Title, SuggestedSellingPrice, NumberInStock, PublisherCode, Publisher Name, <b class="gr">{</b> AuthorCode, AuthorFirstName, AuthorLastName <b class="gr">}</b>, CategoryCode, CategoryDescription )

## 1NF: Repeating Groups

After performing First Normal Form, a new entity was generated: **_Author_**

**Author**: ( <b class="pk"><u class="fk">ISBN</u>, AuthorCode</b>, AuthorFirstName, AuthorLastName )

## 2NF: Partial Dependencies

After performing Third Normal Form, no new entity was generated.

## 3NF: Transitive Dependencies

After performing Third Normal Form, two new entities were generated: **_Publisher_** & **_Category_**

**Publisher**: ( <b class="pk">PublisherCode</b>, PublisherName )

**Category**: ( <b class="pk">CategoryCode</b>, CategoryDescription )


# Entities After 3NF:

**Book**: ( <b class="pk">ISBN</b>, <u class="fk">PublisherCode</u>, <u class="fk">CategoryCode</u>, Title, SuggestedSellingPrice, NumberInStock )

**Author**: ( <b class="pk"><u class="fk">ISBN</u>, AuthorCode</b>, AuthorFirstName, AuthorLastName )

**Publisher**: ( <b class="pk">PublisherCode</b>, PublisherName )

**Category**: ( <b class="pk">CategoryCode</b>, CategoryDescription )




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