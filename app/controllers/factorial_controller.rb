class FactorialController < ApplicationController
    def hello
       @u = 0 
    end

    def calculate
        Publisher.publish("factorial", {message: "hello"})
        @u = `python factorial.py #{params[:input][:number]}`
        render 'hello'
    end

end
