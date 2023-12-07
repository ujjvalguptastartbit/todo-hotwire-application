class CompletedController < ApplicationController
    def allow_cross_domain_access
      response.headers["Access-Control-Allow-Origin"] = '*'
      response.headers["Access-Control-Allow-Methods"] = "GET, PUT, POST, DELETE, OPTIONS"
      response.headers['Access-Control-Request-Method'] = '*'
      response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end
    def update
        @todo = Todo.find(params[:id])
        @todo.completed = !@todo.completed
        
        respond_to do |format|
          if @todo.save
            format.turbo_stream do
              render turbo_stream: [
                turbo_stream.replace(@todo, partial: "todos/todo", locals: { todo: @todo }),  # Replace the updated todo
                turbo_stream.update("todos")  # Update the todo list (if needed)
              ]
            end
            
            format.html { redirect_to todos_path, notice: "Todo status was successfully updated." }
            format.json { render :show, status: :ok, location: @todo }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @todo.errors, status: :unprocessable_entity }
          end
        end
      end
      
end
