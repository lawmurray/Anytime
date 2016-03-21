function image_profile(image_file)
  % events
  events = [];
  %rank = 0;
  %file = sprintf('sir.log.%d', rank);
  %while exist(file, 'file')
for rank=0:127
    file = sprintf('sir.log.%d', mod(rank, 4));

    events1 = dlmread(file);
    events1 = [repmat(rank, rows(events1), 1), events1];
    events = [events; events1];
    %rank = rank + 1;
    %file = sprintf('sir.log.%d', rank);
  end
  nprocs = rank + 1;
  [times, is] = sort(events(:,3));
  events = events(is,:);

  % timelines
  res = 4096;
  times = linspace(0, max(events(:,4)), res + 1)(2:(res + 1))';
  timelines = zeros(nprocs, res, 3);
  j = 1;
  for i=1:rows(events)
    rank = events(i,1) + 1;
    type = events(i,2);
    from = events(i,3);
    to = events(i,4);
    if (type == 4)
      c = [0; 94; 184]/255;
    elseif (type == 1)
      c = watercolour(2)';
    else
      c = 0.7*ones(3,1);
    end

    while times(j) < from
      j = j + 1;
    end
    k = j;
    done = false;
    while !done
      if k > 1
        from1 = max(from, times(k - 1));
        to1 = min(times(k), to);
        w1 = (to1 - from1)/(times(k) - times(k - 1));
      else
        from1 = from;
        to1 = min(times(k), to);
        w1 = (to1 - from1)/times(k);
      end
      timelines(rank,k,:) = squeeze(timelines(rank,k,:)) + w1*c;
      k = k + 1;
      done = k > length(times) || times(k) >= to;
    end
  end

  % fade rows to make distinct
  fd = linspace(0.7, 0.9, nprocs)';
  fd = fd(randperm(nprocs));
  for i=1:nprocs
    timelines(i,:,:) = fd(i)*timelines(i,:,:) + (1.0 - fd(i));
  end

  imwrite(timelines, image_file);
end
