class HomeController < ApplicationController
  require 'mailgun' 
  def index
  end
  
  def write
    @title = params[:title]
    @myaddress = params[:myaddress]
    @address = params[:address]
    @content = params[:content]
    
    mg_client = Mailgun::Client.new("key")
    
    message_params =  {
                       from: @myaddress,
                       to:   @address,
                       subject: @content,
                       text:    @content
                      }
    
    result = mg_client.send_message('sandbox282d6d45e8cd45feb4ab88a1d23db946.mailgun.org', message_params).to_h!
    
    message_id = result['id']
    message = result['message']
    
    @new_post = Post.new
    @new_post.title=@title
    @new_post.content= @content
    @new_post.myaddress= @myaddress
    @new_post.address= @address
    @new_post.save
    
    redirect_to "/list"
  end
  
  def list
    @sended_post = Post.all
  end
  
  def delete
    @one_post = Post.find(params[:id])
    @one_post.delete
    redirect_to "/list"
  end

  def update_view
    @one_post = Post.find(params[:id])
  end

  def update
    @one_post = Post.find(params[:id])
    @one_post.title = params[:title]
    @one_post.myaddress = params[:myaddress]
    @one_post.address = params[:address]
    @one_post.content = params[:content]
    @one_post.save
    
    redirect_to "/list"
  end  
  
end