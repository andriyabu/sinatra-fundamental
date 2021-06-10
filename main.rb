require 'sinatra'

enable :sessions

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
    store_name("name.txt",@name)
    session[:message] = "Successfully stored the name #{@name}"
    redirect "/product?name=#{@name}"
end

get '/signup' do
    "signup page"
end