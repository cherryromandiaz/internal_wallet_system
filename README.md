# Internal Wallet System  

A **wallet management system** built with **Ruby on Rails**, supporting users, teams, and stocks as entities with wallets for money manipulation. The system provides APIs to perform wallet transactions and manage balances.  

---

## **Features**  
- Create wallets for different entities (User, Team, Stock)  
- Perform transactions between wallets  
- Validate transactions to prevent negative balances  
- Retrieve wallet balances and transaction history  
- Reset all data via API  

---

## **Installation Instructions**  

### **Prerequisites**  
Make sure you have the following installed:  
- **Ruby** (>= 3.0)  
- **Rails** (>= 7.2)  
- **SQLite3**

### **Setup Steps**  

### Install the required Ruby gems:
bundle install

### Database Setup
rails db:create
rails db:migrate

### Start the Rails Server
rails server

The server will be available at: http://localhost:3000


