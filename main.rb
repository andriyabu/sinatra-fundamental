require 'sinatra'


get '/' do
    "<h1> omg, welcome to sinatra </h1>"
end

get '/product/:name' do
    
    # "Nama Product adalah #{params[:nama]}"
    # params.inspect
    # ERB.new("<h3> Nama Product adalah  <%= params[:nama] %> </h3>").result(binding)

    # or
    # erb "<h3> Nama Product adalah  <%= nama %> </h3>", {:locals => {:nama => params[:name]}}

    # or

    erb "<h3> Nama Product adalah  <%= name %> </h3>", {:locals => params }
end

# using layout and template
get '/category/:name' do
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
    
    erb :index, {:layout => :layout, :locals =>params}
end

get '/signup' do
    "signup page"
end