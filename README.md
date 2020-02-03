# README

Welcome to the Rales Engine

This application provides endpoint data for sales in categories such as merchant, customer, transaction, invoice, item, and invoice_item.
Information may also be searched through relationships between different categories.

Setup
1. Fork and clone the repository from github
2. Run bundle install
3. Inside the repository, run 'rake import' to seed sales data
4. Use a rails server to locally run all endpoints

Endpoints

  Endpoints can de searched by many categories, including name, id, creation time, last update time, and more.
  Merchants
  To search merchants, use '/merchants' and:
    '/:id' for a specific merchant
    '/find?parameter' to locate a merchant by an attribute
    '/find_all' to locate all merchants matching the parameter

  Customers
  To search customers, use '/customers' and:
    '/:id' for a specific customer
    '/find?parameter' to locate a customer by an attribute
    '/find_all' to locate all customers matching the parameter

  Invoices
  To search invoices, use '/invoices' and:
    '/:id' for a specific invoice
    '/find?parameter' to locate an invoice by an attribute
    '/find_all' to locate all invoices matching the parameter

  Invoice Items
  To search invoice items, use '/invoice_items' and:
    '/:id' for a specific invoice item
    '/find?parameter' to locate an invoice_item by an attribute
    '/find_all' to locate all invoice_items matching the parameter

  Items
  To search customers, use '/items' and:
    '/:id' for a specific item
    '/find?parameter' to locate an item by an attribute
    '/find_all' to locate all items matching the parameter  

  Transactions
  To search customers, use '/transactions' and:
    '/:id' for a specific transaction
    '/find?parameter' to locate a transaction by an attribute
    '/find_all' to locate all transactions matching the parameter  
