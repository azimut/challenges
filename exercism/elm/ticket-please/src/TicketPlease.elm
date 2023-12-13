module TicketPlease exposing (..)

import TicketPleaseSupport exposing (Status(..), Ticket(..), User(..))

emptyComment : ( User, String ) -> Bool
emptyComment (_, comment) = String.isEmpty comment

numberOfCreatorComments : Ticket -> Int
numberOfCreatorComments (Ticket { createdBy, comments }) =
    let (User creator, _) = createdBy in
    comments |> List.filter (\(User user, _) -> user == creator)
             |> List.length

assignedToDevTeam : Ticket -> Bool
assignedToDevTeam (Ticket { assignedTo }) =
    case assignedTo of
        Just (User "Alice") -> True
        Just (User "Bob") -> True
        Just (User "Charlie") -> True
        _ -> False

assignTicketTo : User -> Ticket -> Ticket
assignTicketTo asignee (Ticket ({ status } as ticket)) =
    case status of
        New      -> Ticket { ticket | status = InProgress, assignedTo = Just asignee }
        Archived -> Ticket ticket
        _        -> Ticket { ticket | assignedTo = Just asignee }
