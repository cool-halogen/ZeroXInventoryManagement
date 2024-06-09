import React from 'react';
import { Droppable as OriginalDroppable } from 'react-beautiful-dnd';

const DroppableWrapper = ({ children, droppableId, type = 'DEFAULT', direction = 'vertical', isDropDisabled = false }) => (
  <OriginalDroppable droppableId={droppableId} type={type} direction={direction} isDropDisabled={isDropDisabled}>
    {(provided, snapshot) => children(provided, snapshot)}
  </OriginalDroppable>
);

export default DroppableWrapper;
