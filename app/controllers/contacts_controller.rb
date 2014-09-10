class ContactsController < ApplicationController
 
  def about
    @about_body = true
    
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    
    respond_to do |format|
      if @contact.save
        # Send mail to Newshubby
        ContactMailer.contact_mail(@contact).deliver
        
        format.html { redirect_to about_path, notice: 'Your contact request was sent.' }
        format.json { render :show, status: :created, location: @newsroom }
      else
        format.html { render :new }
        format.json { render json: @newsroom.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to about_path, notice: 'Contact request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
  
end
