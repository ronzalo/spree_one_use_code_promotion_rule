module Spree
  class Promotion
    module Rules
      class OneUseCode < PromotionRule
        attr_reader :email

        def applicable?(promotable)
          promotable.is_a?(Spree::Order)
        end

        def eligible?(order, options = {})
          @email = order.email

          if email
            orders_by_email.blank? || used_codes.blank? || !used_codes.include?(promotion.code)
          else
            false
          end
        end

        private

        def used_codes
          @used_codes ||= begin
             orders_by_email.collect do |order|
              order.adjustments.promotion.eligible.collect { |p| p.originator.promotion.try(:code) }
             end.flatten.uniq
          end

          Rails.logger.info "Historical codes for #{email}: #{@used_codes.inspect}"
          @used_codes
        end

        def orders_by_email
          Spree::Order.complete.where(email: email)
        end

      end
    end
  end
end
