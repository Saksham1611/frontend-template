import { useQuery } from '@tanstack/react-query'

// Tip: Centralize your query keys
export const patientKeys = {
  all: ['patients'] as const,
  details: () => [...patientKeys.all, 'detail'] as const,
  detail: (id: string) => [...patientKeys.details(), id] as const,
}

// Sample data fetching hook
export function usePatientData(id: string) {
  return useQuery({
    queryKey: patientKeys.detail(id),
    queryFn: async () => {
      // In a real app, this would be a fetch call:
      // const response = await fetch(`/api/patients/${id}`)
      // if (!response.ok) throw new Error('Network response was not ok')
      // return response.json()

      // Mocking a delay
      await new Promise((resolve) => setTimeout(resolve, 1000))
      return { id, name: 'John Doe', condition: 'Speech Impairment' }
    },
    enabled: !!id,
  })
}
