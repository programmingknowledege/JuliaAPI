module Practice

using Logging, LoggingExtras

function main()
  Base.eval(Main, :(const UserApp = Practice))

  include(joinpath("..", "genie.jl"))

  Base.eval(Main, :(const Genie = Practice.Genie))
  Base.eval(Main, :(using Genie))
end; main()

end
