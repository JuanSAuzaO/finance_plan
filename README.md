# Finance Plan

## Introduction:

### This application is built as part of my portfolio to demonstrate how to structure an app dedicated to keep tracking of savings funds, which are planned to be linked to real market stock price data. It is currently under development.

### In this first iteration, in which the objective is creating the core design and testing it with a savings fund creation, it features:

### - Database schema definition, with the inclusion of Devise for user migrations and ULID for using Binary ids.
### - Test Driven Development with RSpec, Byebug and Factory Bot.
### - Custom Service Objects implementation.
### - Contracts use for validations using Dry Validation.
### - Custom error formatting and handling.

## Requirements:

### - Ruby version: 3.3.7
### - Rails version: 7.2.2.1
### - Postgresql version: 16
### - Setup:
### 1 `rails db:create`
### 2 `rails db:migrate && rails db:test:prepare`
### 3 `rspec`
### 4 `rails server`
