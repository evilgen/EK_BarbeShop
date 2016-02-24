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
	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@master = params[:master]
	@color = params[:colorpicker]

#Сохранение данных в базе данных
Client.create 	:name=>@username,
 				:phone=>@phone, 
				:datestamp=>@datetime,
				:barber=>@master,
				:color=>@color

@message = "Thank you #{@username}, we will wait for you."

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
	@email = params[:email]
	@letter = params[:letter]

#Сохранение данных в базе данных
Contact.create 	:email=>@email,
 				:letter=>@letter
	
@message = "Thank you for your message."

erb "#{@message}"
end