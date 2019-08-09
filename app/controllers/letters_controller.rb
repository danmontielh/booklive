class LettersController < ApplicationController
  
  def index
    @letter_user_send = current_user.letters_send
    @letter_user_receive = current_user.letters_receiver
  end
  

  def create
    @letter = current_user.letters_send.build(letter_params)
        if @letter.save
            redirect_to user_path(@letter.receiver_id)
        end
  end

  private

  def letter_params
    params.require(:letter).permit(:receiver_id, :message)
end 


end
