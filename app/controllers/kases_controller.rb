class KasesController < ApplicationController
  respond_to :html,:json
  before_filter :login_required, :except => [:index, :show]
  before_filter :find_problem
  before_filter :check_permission, :only => [:destroy,:update]
  
  def index
    @kases = @problem.kases
  end
  
  def new
    @kase = @problem.kases.build
  end
  
  def create
    @kase = @problem.kases.build(params[:kase])
    if @kase.save
      redirect_to problem_path(@problem)
    else
      render :action => 'new'
    end
  end
  
  def update
    @kase.update_attributes(params[:kase])
    redirect_to "#{problem_path(@problem)}/kases/#{@kase.id}"
  end
  
  def destroy
    @kase.destroy
    redirect_to problem_path(@problem)
  end
  
  def show
    @kase = Kase.find(params[:id])
    @problem_kase_ids = @problem.kases.map(&:id)
    @index = @problem_kase_ids.index(@kase.id)
    @prev = Kase.find( @problem_kase_ids[(@index-1) % @problem_kase_ids.size])
    @index != @problem.kases.length - 1 ? @next = Kase.find(@problem.kases[@index+1]) : @next = Kase.find(@problem.kases[0])
    @comments = @kase.comments
  end
  
  private
  def find_problem
    @problem = Problem.find(params[:problem_id])
  end
  
  def check_permission
    @kase = Kase.find(params[:id])
    redirect_to :back unless @kase.user == current_user 
  end
end
