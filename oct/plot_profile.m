function plot_profile(prefix, image_file)
  % events
  events = [];
  times = [];
  rank = 0;
  file = sprintf('%s.log.%d', prefix, rank);
  while exist(file, 'file')
    x = dlmread(file);
    events = [events, x(:,1)];
    times = [times, x(:,2)];

    rank = rank + 1;
    file = sprintf('%s.log.%d', prefix, rank);
  end
  nprocs = rank;

  % timelines
  res = 4096;
  ts = linspace(0, max(times(:)), res + 1);
  ts = ts(2:(res + 1))';
  timelines = zeros(nprocs, res, 3);

  for rank = 1:nprocs
    i = 1;
    event0 = events(i, rank);
    time0 = times(i, rank);
    t = 1;

    for i = 2:size(events, 1)
      event1 = events(i, rank);
      time1 = times(i, rank);

      if (event0 == 1)
        c = [0.0 0.0 0.0]';
      else
        c = [0.7 0.7 0.7]';
      end

      while (t == 1 || ts(t - 1) < time1)
        if t > 1
          from = max(time0, ts(t - 1));
          to = min(time1, ts(t));
          w1 = (to - from)/(ts(t) - ts(t - 1));
        else
          from = time0;
          to = min(time1, ts(t));
          w1 = (to - from)/ts(t);
        end
        timelines(rank,t,:) = squeeze(timelines(rank,t,:)) + w1*c;
        t = t + 1;
      end
      t = t - 1;

      event0 = event1;
      time0 = time1;
    end
  end

  % fade rows to make distinct
  fd = linspace(0.6, 0.9, nprocs)';
  fd = fd(randperm(nprocs));
  for rank = 1:nprocs
    timelines(rank,:,:) = fd(rank)*timelines(rank,:,:) + (1.0 - fd(rank));
  end

  % image
  imwrite(timelines, image_file);

  % plot
  cla;
  image(ts/1e6/60, [1:nprocs]', timelines);
  axis('tight');
  xlabel ('time (min)');
  ylabel ('rank');
  %grid on;
  box on;
  set(gca, 'ticklength', [0 0]);
end
