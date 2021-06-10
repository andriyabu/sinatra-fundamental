require 'sinatra'


enable :sessions

class NameValidator

    def initialize(name, names)
        @name = name.to_s
        @names = names
    end

    def valid?
        validate
        @message.nil?
    end

    def message
        @message
    end      
    
    private

    def validate
        if @name.empty?
          @message = "You need to enter a name."
        elsif @names.include?(@name)
          @message = "#{@name} is already included in our list."
        end
    end
end


get '/' do
    "<h1> omg, welcome to sinatra </h1>"
end

# get '/product/:name' do
    
#     # "Nama Product adalah #{params[:nama]}"
#     # params.inspect
#     # ERB.new("<h3> Nama Product adalah  <%= params[:nama] %> </h3>").result(binding)

#     # or
#     # erb "<h3> Nama Product adalah  <%= nama %> </h3>", {:locals => {:nama => params[:name]}}

#     # or

#     erb "<h3> Nama Product adalah  <%= name %> </h3>", {:locals => params }
# end

# using layout and template
get '/product/:name' do
    # template = "<h1 style='color: red'> Category name <%= name %> </h1>"
    # layout = %(
    #     <html>
    #     <title>
    #         Category
    #     </title>
    #     <body>
    #         <%= yield %>
    #     </body>
    #     </html>
    # )
    # instanse variable
    @name = params[:name]
    
    erb :show_product, {:layout => :layout, :locals =>params}
end

def store_name(filename, string)
    File.open(filename, "a+") do |file|
        file.puts(string)
    end
end

def read_names
    return [] unless File.exists?("name.txt")
    File.read("name.txt").split("\n")    
end

get '/product' do
    # p params
    @message = session.delete(:message)
    @name = params[:name]
    @names = read_names
    erb :product, {:layout => :layout}
end

post '/product' do
    @name = params[:name]
    @names = read_names
    validator = NameValidator.new(@name, @names)

    if validator.valid?
        store_name("name.txt",@name)
        session[:message] = "Successfully stored the name #{@name}"
        redirect "/product?name=#{@name}"
    else
        # session[:message] = validator.message
        @message = validator.message
        erb :product, {:layout => :layout}
    end
    # cek if @name is empty
    # if @name.nil? or @name.empty?
    #     session[:message] = "You need to enter a name"
    # check if name already in the file list
    # elsif read_names.include?(@name)
    #     session[:message] = "#{@name} is already include in our list"
    # else
        # store the @name on the file and create a session
    #     store_name("name.txt",@name)
    #     session[:message] = "Successfully stored the name #{@name}"
    # end

    
end

get '/signup' do
    "signup page"
end