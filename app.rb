#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

#Создание подключения к БД при помощи Active Record
set :database, "sqlite3:EKBarberShop.db"

#Создание сущности Клиент с наследованием
class Client < ActiveRecord::Base
	validates :name, presence: true
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
end

#Создание сущности Парикмахер с наследованием
class Barber < ActiveRecord::Base
end

#Создание сущности Контакт с наследованием
class Contact < ActiveRecord::Base
	validates :email, presence: true
	validates :letter, presence: true
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
	@notation = Client.new
	erb :visit
end

#обработчие post-запроса /visit
#браузер отправляет страницу на сервер
post '/visit' do
#Сохранение данных в базе данных
@notation = Client.new params[:client]
	if @notation.save
		erb "Thank you, we will wait for you."
	else
		@error = @notation.errors.full_messages.first
		erb :visit
	end
end

#обработчик get-запроса /contacts
#браузер получает страницу с сервера
get '/contacts' do
	@con = Contact.new	
	erb :contacts
end

#обработчие post-запроса /contacts
#браузер отправляет страницу на сервер
post '/contacts' do
#Сохранение данных в базе данных
@con = Contact.new params[:contact]
	if @con.save
		erb "Thank you for your message."
	else
		@error = @con.errors.full_messages.first
		erb :contacts
	end
end

get '/barber/:id' do
	@barber = Barber.find(params[:id])
	erb :barber
end
