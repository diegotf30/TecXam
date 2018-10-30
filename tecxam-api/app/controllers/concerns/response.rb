module Response
  def json_response(resource, status = :ok)
    if index_query?(resource) || resource.errors.empty?
      render json: resource, status: status
    else
      validation_error(resource)
    end
  end
  
  def validation_error(resource)
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status: :bad_request
  end

  private

  def index_query?(resource)
    resource.kind_of?(ActiveRecord::Relation)
  end
end
