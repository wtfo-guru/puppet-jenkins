require 'spec_helper'
describe 'jenkins', :type => :class do
  on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

    case facts[:osfamily]
    when 'Debian'
      augeas_context = '/files/etc/default/jenkins'
    else
      augeas_context = '/files/etc/sysconfig/jenkins'
    end
    it { is_expected.to compile }
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('jenkins') }
    it { is_expected.to contain_class('jenkins::install').that_comes_before('Class[jenkins::config]') }
    it { is_expected.to contain_class('jenkins::config').that_comes_before('Class[jenkins::service]') }
    it { is_expected.to contain_class('jenkins::service') }

    context 'jenkins::install defaults' do
      it { is_expected.to contain_package('jenkins') }
      case facts[:osfamily]
      when 'Debian'
        it { is_expected.to contain_apt__source('jenkins-stable') }
      else
        it { is_expected.to contain_yumrepo('jenkins') }
      end
    end

    context 'jenkins::config defaults' do
      it { is_expected.to contain_augeas('jenkins_homedir').with({
        'context' => "#{augeas_context}",
         })
      }
      it { is_expected.to contain_augeas('jenkins_user').with({
        'context' => "#{augeas_context}",
        })
      }
      it { is_expected.to contain_augeas('jenkins_java_args').with({
        'context' => "#{augeas_context}",
         })
      }
      it { is_expected.to contain_augeas('jenkins_http_listen_address').with({
        'context' => "#{augeas_context}",
         })
      }
      it { is_expected.to contain_augeas('jenkins_http_port').with({
        'context' => "#{augeas_context}",
         })
      }
      it { is_expected.to contain_augeas('jenkins_debug_level').with({
        'context' => "#{augeas_context}",
         })
      }
      it { is_expected.to contain_augeas('jenkins_enable_access_log').with({
        'context' => "#{augeas_context}",
         })
      }
      it { is_expected.to contain_augeas('jenkins_handler_max').with({
        'context' => "#{augeas_context}",
         })
      }
      it { is_expected.to contain_augeas('jenkins_handler_idle').with({
        'context' => "#{augeas_context}",
         })
      }
    end

    context 'jenkins::service defaults' do
      it { is_expected.to contain_service('jenkins').with({
        'ensure' => 'running',
        'enable' => true,
        })
      }
    end

    context 'jenkins::config when enable_https true' do

      let(:params) { {'enable_https' => true} }

      it { is_expected.to contain_augeas('jenkins_https_port').with({
        'context' => "#{augeas_context}",})
      }
      it { is_expected.to contain_augeas('jenkins_https_keystore').with({
        'context' => "#{augeas_context}",})
      }
      it { is_expected.to contain_augeas('jenkins_https_keystore_password').with({
        'context' => "#{augeas_context}",})
      }
      it { is_expected.to contain_augeas('jenkins_https_listen_address').with({
        'context' => "#{augeas_context}",})
      }

    end

    end
  end

end
