export const UPDATE_CLEANER_STATUS = 'UPDATE_CLEANER_STATUS';

export function updateCleanerStatus(cleanerStatus) {
  return {
    type: UPDATE_CLEANER_STATUS,
    cleanerStatus
  };
}
