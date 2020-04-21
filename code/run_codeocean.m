% check if on codeocean, error out if not
try
    if ~is_codeocean() % test codeocean detection
        'ERROR: run_codeocean.m should only be executed on the codeocean platform'
        return;
    end
catch
    'ERROR: path likely not set, run install.m'
end

cd /code/nnv/examples/Submission/CAV2020_ImageStar/

cd MNIST_NETS/Small
plot_ranges
saveas(gcf, '/results/figure8_mnist_small.png')

% table 1
compare_star_absdom_short % ~ 5 min
%compare_star_absdom % full version: 10:41 total

% table 2
% next together: > 1.5 hours for short version
cd ../Medium
compare_star_absdom_short
%compare_star_absdom  % full version: 10:41 total

% table 3
cd ../Large
compare_star_absdom_short
%compare_star_absdom  % full version: 10:41 total


cd /code/nnv/examples/Submission/CAV2020_ImageStar/

% table 4
cd VGG16/Compare_Polytope_ImageStar
verify_VGG16 % takes ~1:38 hours:min

% table 5
cd ../Compare_Exact_vs_Approx
verify_robustness_delta_2e_07 % ~15 min

verify_robustness_delta_e_07 % ~15 min

cd /code/nnv/examples/Submission/CAV2020_ImageStar/

% table 4
cd VGG19/Compare_Polytope_ImageStar
verify_VGG19 % 1:10

% table 5
cd ../Compare_Exact_vs_Approx
verify_robustness_delta_2e_07 % ~34 min

verify_robustness_delta_e_07 % ~17 min

cd ../Plot_Figures

% 1:05 total for figs 9-12
% additionally, had an OOM, so checking
% figure 9
plot_vgg19_exact_range % ~3min
saveas(gcf, '/results/logs/vgg19/figure9_vgg19.png')

% figure 10
plot_vgg19_counter_example % ~3min, possible OOM
saveas(gcf, '/results/logs/vgg19/figure10_vgg19.png')

% figure 11
plot_vgg19_reachTime % ~4min
saveas(gcf, '/results/logs/vgg19/figure11_vgg19.png')

% figure 12
plot_vgg19_inputSize_effect % ~55min
saveas(gcf, '/results/logs/vgg19/figure12_vgg19.png')


return


cd /code/nnv/examples/Submission/CAV2020/

% examples to manually run nnv on acas-xu, these (and many more) are 
% run from run_scripts automatically
%verify_P0_N00_abs(1,1)
%verify_P0_N00_star_appr(1,1)
%verify_P0_N00_star(1,1)
%verify_P0_N00_zono(1,1)

cd ACC;
pwd

% run all closed-loop CPS examples
reproduce % will take ~32.5 minutes (see run 140515 or 152224)



%return; % stop here, comment/remove this to run all tests, other examples, etc.
% if you run all these, it will add another ~15 minutes of runtime

cd /code/nnv/tests/set/zono

% run a few tests before starting batch run (as examples to illustrate how to run individiual examples / tests)
pwd
test_zono_convexHull
pwd
saveas(gcf, '/results/results_fig1.png')

't1'
% star tests, all failed (yalmip)
test_star_plotBoxes_2D
pwd
saveas(gcf, '/results/results_fig2.png')

't2'
test_star_plotBoxes_3D
saveas(gcf, '/results/results_fig3.png')

't3'
pwd

dir_results = '/results/';

% global variables for batch test runs
% some tests need to be disabled for codeocean due to differences on running without a UI, etc.
i_d = 1; disabledTests = {'test_CNN_parse'} ; global i_d disabledTests;

cd '/code/nnv/tests';
pwd

% run all tests, recursively runs all tests in the code/nnv/tests directory
run_all_tests(dir_results, disabledTests, i_d) % add directory for results input and use dir_root/results

'after all batch tests run'

% Next, start some of the examples, these are not run inside of the 
% batch test execution, and can be extended/modified to run other 
% examples.
%
% We do not batch all of these as the runtime for everything would be on 
% the order of several days at least.
%'start nncs tests'
%cd /code/nnv/examples/NNCS/InvertedPendulum;
%reach_inverted_pendulum_control_sys;
%saveas(gcf, '/results/results_nncs_invpend_fig1.png')

%cd '/code/nnv/examples/NNCS/ACC/Verification/Scenarios 1'
%verify_controller_3_20;
%saveas(gcf, '/results/results_nncs_acc_s1_fig1.png')

%cd '/code/nnv/examples/NNCS/ACC/Verification/Scenarios 2'
%reach_nncACCsystem;
%saveas(gcf, '/results/results_nncs_acc_s2_fig1.png')

%'after nncs tests'