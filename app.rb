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

#Создание сущности Парикмахер с наследованием
class Barber < ActiveRecord::Base
end

#Создание сущности Контакт с наследованием
class Contact < ActiveRecord::Base
end


#before вызывается каждый раз при перезагрузке
#любой страницы
before do
	@barbers = Barber.all
end

get '/' do
	erb :index			
end

#обработчик get-запроса /visit
#браузер получает страницу с сервера
get '/visit' do
	erb :visit
end

#обработчие post-запроса /visit
#браузер отправляет страницу на сервер
post '/visit' do
#Сохранение данных в базе данных
@notation = Client.new params[:client]
@notation.save

@message = "Thank you, we will wait for you."

erb "#{@message}"
end

#обработчик get-запроса /contacts
#браузер получает страницу с сервера
get '/contacts' do
	erb :contacts
end

#обработчие post-запроса /contacts
#браузер отправляет страницу на сервер
post '/contacts' do
#Сохранение данных в базе данных
@con = Contact.new params[:contact]
@con.save
	
@message = "Thank you for your message."

erb "#{@message}"
end