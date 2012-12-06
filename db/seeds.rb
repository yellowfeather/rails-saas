# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tenant1 = Tenant.create! :name => 'Cheese', :subdomain => 'cheese'
tenant2 = Tenant.create! :name => 'Bacon', :subdomain => 'bacon'

user1 = User.create! :tenant_id = tenant1.id, :email => 'cheese@example.com', :password => 'please', :password_confirmation => 'please', :confirmed_at => Time.now.utc
user2 = User.create! :tenant_id = tenant2.id, :email => 'bacon@example.com', :password => 'please', :password_confirmation => 'please', :confirmed_at => Time.now.utc


