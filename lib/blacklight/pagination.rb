module Blacklight
  module Pagination
    def self.paginate_params(response)

      per_page = response.rows
      per_page = 1 if per_page < 1

      current_page = (response.start / per_page).ceil + 1
      num_pages = (response.total / per_page.to_f).ceil

      total_count = response.total

      start_num = response.start + 1
      end_num = start_num + response.docs.length - 1

      PageInfo.new(:start => start_num,
                     :end => end_num,
                     :per_page => per_page,
                     :current_page => current_page,
                     :num_pages => num_pages,
                     :limit_value => per_page, # backwards compatibility
                     :total_count => total_count,
                     :first_page? => current_page > 1,
                     :last_page? => current_page < num_pages
        )
    end

    class PageInfo < OpenStruct
      def as_json(props = nil)
        table.as_json(props)
      end
    end
  end
end
