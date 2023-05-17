class Admin::QuestionsController < ApplicationController
  before_action :authenticate_user!, :ensure_admin

  def index
    @questions = Question.all
  end

  def edit
    @question = Question.find(params[:id])
  end  

  def update
    @question = Question.find(params[:id])
    @question.update(answered_by: current_user)
    if @question.update(question_params)
      redirect_to admin_questions_path, notice: 'Pergunta atualizada com sucesso.'
    else
      render :edit
    end
  end

  private

  def question_params
    params.require(:question).permit(:answer, :hidden)
  end

  def ensure_admin
    redirect_to root_path, alert: 'Acesso não autorizado.' unless current_user.admin?
  end
end
