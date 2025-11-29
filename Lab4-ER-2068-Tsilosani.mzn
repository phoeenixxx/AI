% --- Decision Variables ---
% We need to determine the Slot, Teacher and Room for every combination of Group and Class. This ensures every group takes every class exactly once.

array[Groups, Classes] of var Slots: schedule_slot;
array[Groups, Classes] of var Teachers: schedule_teacher;
array[Groups, Classes] of var Rooms: schedule_room;


% --- Constraints ---

% Teachers can only teach classes listed in their 'CanTeach' set.
constraint forall(g in Groups, c in Classes)(
    c in CanTeach[schedule_teacher[g,c]]
);

% Classes must be held in rooms listed in their 'Suitable' set.
constraint forall(g in Groups, c in Classes)(
    schedule_room[g,c] in Suitable[c]
);

% A single student group cannot attend two different classes at the same Slot.
constraint forall(g in Groups, c1, c2 in Classes where c1 < c2)(
    schedule_slot[g,c1] != schedule_slot[g,c2]
);

%Teacher and Room Non-Bilocation (Resource Constraints): We check every pair of events (g1, c1) and (g2, c2).
% If they are distinct events (not the same group and class) AND they happen at the same Slot, then they MUST have different Teachers and different Rooms.
constraint forall(g1, g2 in Groups, c1, c2 in Classes where (g1 != g2 \/ c1 != c2))(
    if schedule_slot[g1,c1] == schedule_slot[g2,c2] then
        schedule_teacher[g1,c1] != schedule_teacher[g2,c2] /\
        schedule_room[g1,c1] != schedule_room[g2,c2]
    endif
);


% --- Solve Item ---
solve satisfy;


% --- Output ---
% Formatted exactly as requested: "Slot Group Class Teacher Room"
output [
    show(schedule_slot[g,c]) ++ " " ++ 
    show(g) ++ " " ++ 
    show(c) ++ " " ++ 
    show(schedule_teacher[g,c]) ++ " " ++ 
    show(schedule_room[g,c]) ++ "\n"
    | g in Groups, c in Classes
];