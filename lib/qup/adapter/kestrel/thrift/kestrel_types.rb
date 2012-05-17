#
# Autogenerated by Thrift Compiler (0.8.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#


module Qup
  module Adapter
    module Kestrel
      module Thrift
        class Item
          include ::Thrift::Struct, ::Thrift::Struct_Union
          DATA = 1
          ID = 2

          FIELDS = {
            DATA => {:type => ::Thrift::Types::STRING, :name => 'data', :binary => true},
            ID => {:type => ::Thrift::Types::I64, :name => 'id'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class QueueInfo
          include ::Thrift::Struct, ::Thrift::Struct_Union
          HEAD_ITEM = 1
          ITEMS = 2
          BYTES = 3
          JOURNAL_BYTES = 4
          AGE = 5
          WAITERS = 6
          OPEN_TRANSACTIONS = 7

          FIELDS = {
            HEAD_ITEM => {:type => ::Thrift::Types::STRING, :name => 'head_item', :binary => true, :optional => true},
            ITEMS => {:type => ::Thrift::Types::I64, :name => 'items'},
            BYTES => {:type => ::Thrift::Types::I64, :name => 'bytes'},
            JOURNAL_BYTES => {:type => ::Thrift::Types::I64, :name => 'journal_bytes'},
            AGE => {:type => ::Thrift::Types::I64, :name => 'age'},
            WAITERS => {:type => ::Thrift::Types::I32, :name => 'waiters'},
            OPEN_TRANSACTIONS => {:type => ::Thrift::Types::I32, :name => 'open_transactions'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

      end
    end
  end
end
