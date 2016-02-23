#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

#Создание подключения к БД при помощи Active Record
set :database, "sqlite3:EKBarberShop.db"

#Создание сущности Клиент с наследованием
class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end


get '/' do
	erb :index			
end