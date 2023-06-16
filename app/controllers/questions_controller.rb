class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @lot = Lot.find(params[:lot_id])
    @questions = @lot.questions.visible
  end

  def create
    @lot = Lot.find(params[:lot_id])
    @question = @lot.questions.build(question_params)
    @question.user = current_user

    if @question.save
      redirect_to @lot, notice: 'Pergunta enviada com sucesso.'
    else
      flash[:alert] = 'Erro ao enviar pergunta.'
      render 'lots/show'
    end
  end

  private

  def question_params
    params.require(:question).permit(:content)
  end
end
