%% BEauty plots for the document
%First you have to run the data importer!
%% Plot data signals
period = 1/32;
t=1:period:500;
time_index = 0;
cmap = colormap(lines(14));
subplot(1,1,1)

%1
aux = 1;
time_index = time_index + size(Data{1,1}(:,3),1);
plot(t(aux:time_index) ,Data{1,1}(:,3), 'Color',cmap(1,:),'LineWidth',1.5);
hold on

%2
aux = time_index+1;
time_index = time_index + size(Data{13,1}(:,3),1);
plot(t(aux:time_index), Data{13,1}(:,3), 'Color',cmap(2,:),'LineWidth',1.5);
hold on

%3
aux = time_index+1;
time_index = time_index + size(Data{148,1}(:,3),1);
plot(t(aux:time_index), Data{148,1}(:,3), 'Color',cmap(3,:),'LineWidth',1.5);
hold on

%4
aux = time_index+1;
time_index = time_index + size(Data{177,1}(:,3),1);
plot(t(aux:time_index), Data{177,1}(:,3), 'Color',cmap(4,:),'LineWidth',1.5);
hold on

%5
aux = time_index+1;
time_index = time_index + size(Data{227,1}(:,3),1);
plot(t(aux:time_index), Data{227,1}(:,3), 'Color',cmap(5,:),'LineWidth',1.5);
hold on

%6
aux = time_index+1;
time_index = time_index + size(Data{328,1}(:,3),1);
plot(t(aux:time_index), Data{328,1}(:,3), 'Color',cmap(6,:),'LineWidth',1.5);
hold on

%7
aux = time_index+1;
time_index = time_index + size(Data{333,1}(:,3),1);
plot(t(aux:time_index), Data{333,1}(:,3), 'Color',cmap(7,:),'LineWidth',1.5);
hold on

% Customize axis box for current subplot
grid on
xlabel('time (s)')
ylabel('a_z (m s^{-2})')
xlim([t(1), t(time_index)])

legend('Brush theeth','Climb stairs','comb hair','Descend stairs','Drink glass','Eat meat','Eat soup')

figure
time_index = 0;

%8
aux = 1;
time_index = time_index + size(Data{359,1}(:,3),1);
plot(t(aux:time_index) ,Data{359,1}(:,3), 'Color',cmap(1,:),'LineWidth',1.5);
hold on

%9
aux = time_index+1;
time_index = time_index + size(Data{470,1}(:,3),1);
plot(t(aux:time_index), Data{470,1}(:,3), 'Color',cmap(2,:),'LineWidth',1.5);
hold on

%10
aux = time_index+1;
time_index = time_index + size(Data{510,1}(:,3),1);
plot(t(aux:time_index), Data{510,1}(:,3), 'Color',cmap(3,:),'LineWidth',1.5);
hold on

%11
aux = time_index+1;
time_index = time_index + size(Data{615,1}(:,3),1);
plot(t(aux:time_index), Data{615,1}(:,3), 'Color',cmap(4,:),'LineWidth',1.5);
hold on

%12
aux = time_index+1;
time_index = time_index + size(Data{730,1}(:,3),1);
plot(t(aux:time_index), Data{730,1}(:,3), 'Color',cmap(5,:),'LineWidth',1.5);
hold on

%13
aux = time_index+1;
time_index = time_index + size(Data{850,1}(:,3),1);
plot(t(aux:time_index), Data{850,1}(:,3), 'Color',cmap(6,:),'LineWidth',1.5);
hold on

%14
aux = time_index+1;
time_index = time_index + size(Data{900,1}(:,3),1);
plot(t(aux:time_index), Data{900,1}(:,3), 'Color',cmap(7,:),'LineWidth',1.5);
hold on

% Customize axis box for current subplot
grid on
xlabel('time (s)')
ylabel('a_z (m s^{-2})')
xlim([t(1), t(time_index)])

legend('Get up from bed', 'Liedown bed','pour water','sitdown chair','standup chair','use telephone','walk')


%% Plot x,y,z axis of walking
figure
time_index = size(Data{900,1}(:,3),1);
plot(t(1:time_index), Data{900,1}(:,1), 'Color',cmap(1,:),'LineWidth',1.5);
hold on
plot(t(1:time_index), Data{900,1}(:,2), 'Color',cmap(2,:),'LineWidth',1.5);
hold on
plot(t(1:time_index), Data{900,1}(:,3), 'Color',cmap(3,:),'LineWidth',1.5);

% Customize axis box for current subplot
grid on
xlabel('time (s)')
ylabel('a_z (m s^{-2})')
xlim([t(1), t(time_index)])

legend('a_x', 'a_y','a_z')


%% Plot autocorrelation of the signal

