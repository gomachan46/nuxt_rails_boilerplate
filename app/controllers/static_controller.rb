class StaticController < ActionController::Base
def index
    render file: 'public/index.html', content_type: 'text/html'
  end
end
